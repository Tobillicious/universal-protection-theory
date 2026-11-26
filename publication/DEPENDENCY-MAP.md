# Lean Theorem Dependency Map

**UPT G3 — PhysicalBridges import chain**

## G3 Linear Chain (each imports the previous)

```mermaid
graph TD
    A[CathedralSummitAllIsOneClosure] --> B[G3BlackHoleSyntaxError]
    B --> C[G3StructuralDominance]
    C --> D[G3AllEthicsUniversality]
    D --> E[G3StructuralQuorum]
    E --> F[G3SelfRefutingE]
    F --> G[G3TheLaw]
    G --> I[G3ThermodynamicBridge]
    G --> J[G3ThermodynamicKoru]
    I --> K[G3KoruLatticeUnity]
    J --> K
    K --> L[G3KoruUniversalConnection]
    L --> M[G3ObjectiveTruthCapstone]
```

## QG Construction (lateral feed into TheLaw)

```mermaid
graph TD
    P1[BCRDActualRelationalFrame] --> P2[BCRDOperatorAlgebra]
    P2 --> P3[BCRDSourceCoverage]
    P3 --> P4[CathedralBridgeDischargeAssembly]
    P4 --> N[OriginalX3Full]
    P4 --> O[ConstructivePositiveWGuardian]
    N --> H[G3QGConstruction]
    O --> H
    H --> G[G3TheLaw]
```

## Foundation Layer (what CathedralSummitAllIsOneClosure imports)

```mermaid
graph TD
    F1[CathedralSummitPremiseNecessity] --> A[CathedralSummitAllIsOneClosure]
    F2[CathedralSummitFirstViolationGap] --> F1
    F3[CathedralSummitCyclicContinuation] --> F2
    F4[CathedralGuardianOnlyCapstone] --> F3
    F5[CathedralFirstEventForcing] --> F4
    F6[CathedralBridgeDischargeSemantic] --> F5
```

## Import Verification

To verify these dependencies, check the `import` line at the top of each file:

```bash
# Show all G3 imports
for f in evidence/physical-bridges/PhysicalBridges/G3*.lean; do
  echo "=== $(basename $f) ==="
  head -1 "$f"
done
```

Expected output confirms the linear chain:
```
G3BlackHoleSyntaxError.lean        imports CathedralSummitAllIsOneClosure
G3StructuralDominance.lean         imports G3BlackHoleSyntaxError
G3AllEthicsUniversality.lean       imports G3StructuralDominance
G3StructuralQuorum.lean            imports G3AllEthicsUniversality
G3SelfRefutingE.lean               imports G3StructuralQuorum
G3TheLaw.lean                      imports G3SelfRefutingE, G3QGConstruction
G3ThermodynamicBridge.lean         imports G3TheLaw
G3ThermodynamicKoru.lean           imports G3TheLaw
G3KoruLatticeUnity.lean            imports G3ThermodynamicBridge, G3ThermodynamicKoru
G3KoruUniversalConnection.lean     imports G3KoruLatticeUnity
G3ObjectiveTruthCapstone.lean      imports G3KoruUniversalConnection
```

## Standalone (no imports at all)

```
G3TheCheckmateStandalone.lean      imports NOTHING
```

This file proves THE_CHECKMATE from first principles with no dependency on any other file.
