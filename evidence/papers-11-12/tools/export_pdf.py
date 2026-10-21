"""Optional PDF/HTML export from the two Markdown sources. Requires ReportLab.

Not part of mathematical reproduction. Run from any directory; outputs are written to the package root.
"""
from pathlib import Path
from html import escape
import hashlib,json,re
from functools import partial
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer,Table,TableStyle,Preformatted,KeepTogether

ROOT=Path(__file__).resolve().parents[1]
FONTDIR=Path('/System/Library/Fonts/Supplemental')
FONTS={'Body':'Georgia.ttf','Bold':'Georgia Bold.ttf','Italic':'Georgia Italic.ttf',
       'BoldItalic':'Georgia Bold Italic.ttf','Mono':'Courier New.ttf','Unicode':'Arial Unicode.ttf'}
INK=colors.HexColor('#172f38');ACCENT=colors.HexColor('#326653');PALE=colors.HexColor('#e9f0ec')
for name,file in FONTS.items():pdfmetrics.registerFont(TTFont(name,str(FONTDIR/file)))
pdfmetrics.registerFontFamily('Body',normal='Body',bold='Bold',italic='Italic',boldItalic='BoldItalic')

# A single fallback font covers every non-ASCII source character, including mathematical notation.
def literal(s):
    out=[];run=[];special=None
    def flush():
        if run:
            value=escape(''.join(run),quote=False)
            out.append('<font name="Unicode">'+value+'</font>' if special else value);run.clear()
    for c in s:
        flag=ord(c)>127
        if flag and ord(c) not in pdfmetrics.getFont('Unicode').face.charWidths:
            raise ValueError('missing Unicode glyph: '+repr(c))
        if special is not None and flag!=special:flush()
        special=flag;run.append(c)
    flush();return ''.join(out)

def inline(s):
    pattern=r'(\*\*[^*]+\*\*|`[^`]+`|\[[^]]+\]\([^)]+\)|\*[^*]+\*)'
    parts=[]
    for x in re.split(pattern,s):
        if x.startswith('**') and x.endswith('**'):parts.append('<b>'+literal(x[2:-2])+'</b>')
        elif x.startswith('`') and x.endswith('`'):parts.append('<font name="Mono">'+literal(x[1:-1])+'</font>')
        elif x.startswith('[') and (m:=re.fullmatch(r'\[([^]]+)\]\(([^)]+)\)',x)):
            parts.append('<link href="'+escape(m[2],quote=True)+'" color="#326653">'+literal(m[1])+'</link>')
        elif x.startswith('*') and x.endswith('*'):parts.append('<i>'+literal(x[1:-1])+'</i>')
        else:parts.append(literal(x))
    return ''.join(parts)

def blocks(md):
    lines=md.splitlines();i=0
    while i<len(lines):
        line=lines[i]
        if not line.strip():i+=1;continue
        if line.startswith('|'):
            rows=[]
            while i<len(lines) and lines[i].startswith('|'):
                cells=[x.strip() for x in lines[i].strip().strip('|').split('|')]
                if not all(re.fullmatch(':?-+:?',x.replace(' ','')) for x in cells):rows.append(cells)
                i+=1
            yield ('table',rows);continue
        if (m:=re.match(r'^(#{1,3}) (.*)$',line)):
            yield ('h'+str(len(m[1])),m[2]);i+=1;continue
        if (m:=re.match(r'^\s*(-|\d+\.) (.*)$',line)):
            yield ('item',('bullet' if m[1]=='-' else m[1],m[2],len(line)-len(line.lstrip())))
            i+=1;continue
        if line.startswith('    '):
            code=[]
            while i<len(lines) and lines[i].startswith('    '):code.append(lines[i][4:]);i+=1
            yield ('code','\n'.join(code));continue
        para=[line.strip()];i+=1
        while i<len(lines) and lines[i].strip() and not re.match(r'^(#|\||\s*(-|\d+\.) |    )',lines[i]):
            para.append(lines[i].strip());i+=1
        yield ('p',' '.join(para))

def styles(summary):
    size=9.05 if summary else 10.1;lead=12 if summary else 14.2
    body=ParagraphStyle('body',fontName='Body',fontSize=size,leading=lead,textColor=INK,
                        spaceAfter=5 if summary else 7,allowWidows=0,allowOrphans=0)
    return {'p':body,
      'h1':ParagraphStyle('title',parent=body,fontName='Bold',fontSize=21 if summary else 26,leading=25 if summary else 31,spaceAfter=9 if summary else 14,keepWithNext=True),
      'h2':ParagraphStyle('heading',parent=body,fontName='Bold',fontSize=10.5 if summary else 14,leading=14 if summary else 18,spaceBefore=7 if summary else 15,spaceAfter=4 if summary else 7,keepWithNext=True,textColor=ACCENT),
      'h3':ParagraphStyle('subtitle',parent=body,fontName='Italic',fontSize=11 if summary else 13,leading=15 if summary else 18,spaceAfter=9,keepWithNext=True),
      'item':ParagraphStyle('item',parent=body,leftIndent=10,firstLineIndent=0,bulletIndent=0,spaceAfter=4 if summary else 6),
      'cell':ParagraphStyle('cell',parent=body,fontSize=8.7,leading=11.6,spaceAfter=0),
      'th':ParagraphStyle('th',parent=body,fontName='Bold',fontSize=9,leading=12,spaceAfter=0),
      'code':ParagraphStyle('code',parent=body,fontName='Mono',fontSize=9,leading=12,leftIndent=12,spaceBefore=5,spaceAfter=8)}

def footer(canvas,doc):
    canvas.saveState();w,h=A4
    canvas.setStrokeColor(PALE);canvas.line(doc.leftMargin,31,w-doc.rightMargin,31)
    canvas.setFont('Body',7);canvas.setFillColor(INK)
    canvas.drawString(doc.leftMargin,21,'UPT - local v1.5 repaired candidate - 21 October 2026')
    canvas.drawRightString(w-doc.rightMargin,21,str(doc.page));canvas.restoreState()

def pdf(md,target,summary=False):
    sty=styles(summary);story=[];margin=38 if summary else 43
    usable=A4[0]-2*margin
    parsed=list(blocks(md));pending_heading=None
    for ix,(kind,value) in enumerate(parsed):
        if kind=='h2' and ix+1<len(parsed) and parsed[ix+1][0]=='table':
            pending_heading=value;continue
        if kind=='table':
            n=len(value[0])
            widths=([75,320,usable-395] if n==3 else [99,usable-99])
            if n==3 and value[0][0]=='Instrument':widths=[112,206,usable-318]
            rows=[[Paragraph(inline(c),sty['th' if i==0 else 'cell']) for c in row] for i,row in enumerate(value)]
            table_heading=pending_heading is not None
            if table_heading:
                rows.insert(0,[Paragraph(inline(pending_heading),sty['h2'])]+['']*(n-1));pending_heading=None
            header=1 if table_heading else 0
            t=Table(rows,colWidths=widths,repeatRows=header+1,hAlign='LEFT',splitByRow=1)
            t.setStyle(TableStyle([('VALIGN',(0,0),(-1,-1),'TOP'),('BACKGROUND',(0,header),(-1,header),PALE),
              ('LINEBELOW',(0,header),(-1,header),.7,ACCENT),('LINEBELOW',(0,header+1),(-1,-1),.3,colors.HexColor('#cbd7d1')),
              ('LEFTPADDING',(0,0),(-1,-1),6),('RIGHTPADDING',(0,0),(-1,-1),6),
              ('TOPPADDING',(0,0),(-1,-1),7),('BOTTOMPADDING',(0,0),(-1,-1),7)]))
            if table_heading:t.setStyle(TableStyle([('SPAN',(0,0),(-1,0)),('LEFTPADDING',(0,0),(-1,0),0),('TOPPADDING',(0,0),(-1,0),9)]))
            story.extend([t,Spacer(1,8)])
        elif kind=='item':
            marker,text,indent=value
            marker='-' if marker=='bullet' else marker
            keep=marker!='-' and ix+1<len(parsed) and parsed[ix+1][0]=='item' and parsed[ix+1][1][0]!='bullet'
            item=ParagraphStyle('nested',parent=sty['item'],leftIndent=10+(8 if indent else 0),bulletIndent=0+(8 if indent else 0),keepWithNext=keep)
            story.append(Paragraph(inline(text),item,bulletText=marker))
        elif kind=='code':story.append(Preformatted(value,sty['code']))
        else:
            keep=kind=='p' and ix+1<len(parsed) and parsed[ix+1][0]=='item' and parsed[ix+1][1][0]=='1.'
            chosen=ParagraphStyle('before-list',parent=sty[kind],keepWithNext=True) if keep else sty[kind]
            story.append(Paragraph(inline(value),chosen))
    doc=SimpleDocTemplate(str(target),pagesize=A4,rightMargin=margin,leftMargin=margin,
        topMargin=32 if summary else 42,bottomMargin=40,title='The Universal Protection Theory - '+('one page summary' if summary else 'preprint'),
        author='Tobias Croydon-McRae and (Snuffy) Princess Snuffleupagus; local repair prepared by Codex',pageCompression=1)
    doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=partial(canvas.Canvas,invariant=1))

def html(md,target):
    body=[]
    for kind,value in blocks(md):
        if kind=='table':body.append('<table>'+''.join('<tr>'+''.join('<td>'+inline(c)+'</td>' for c in row)+'</tr>' for row in value)+'</table>')
        elif kind=='item':body.append('<p class="item">'+inline(value[1])+'</p>')
        elif kind=='code':body.append('<pre>'+escape(value)+'</pre>')
        else:body.append('<'+kind+'>'+inline(value)+'</'+kind+'>')
    # Inline output is a small safe markup subset; PDF-specific font tags become ordinary spans.
    text='\n'.join(body);text=re.sub(r'<font name="([^"]+)">',r'<span class="\1">',text).replace('</font>','</span>')
    text=re.sub(r'<link href="([^"]+)" color="[^"]+">',r'<a href="\1">',text).replace('</link>','</a>')
    target.write_text('<!doctype html>\n<html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>UPT - repaired candidate summary</title><style>body{font:17px/1.5 Georgia,serif;color:#172f38;max-width:850px;margin:40px auto;padding:0 24px}h1{line-height:1.2}h2{font-size:1.15em;color:#326653}.item{margin-left:18px}b{font-weight:700}.Mono{font-family:monospace}a{color:#326653}@media print{body{font-size:10pt;margin:0}h2{break-after:avoid}p{orphans:2;widows:2}}</style>\n<body>\n'+text+'\n</body></html>\n')

def main():
    records=[]
    for stem in ('PREPRINT','ONE-PAGE-SUMMARY'):
        source=ROOT/(stem+'.md');target=ROOT/(stem+'.pdf');md=source.read_text()
        pdf(md,target,summary=stem=='ONE-PAGE-SUMMARY')
        records.append({'source':source.name,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
                        'pdf':target.name,'pdf_sha256':hashlib.sha256(target.read_bytes()).hexdigest()})
    html(ROOT.joinpath('ONE-PAGE-SUMMARY.md').read_text(),ROOT/'ONE-PAGE-SUMMARY.html')
    data={'generator':'tools/export_pdf.py','generator_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'exports':records,'html_source':'ONE-PAGE-SUMMARY.md',
          'html_sha256':hashlib.sha256((ROOT/'ONE-PAGE-SUMMARY.html').read_bytes()).hexdigest()}
    (ROOT/'PDF-SOURCES.json').write_text(json.dumps(data,sort_keys=True,indent=2)+'\n')
    print(json.dumps({'pdfs':2,'html':1,'sources_bound':True},sort_keys=True))
if __name__=='__main__':main()
