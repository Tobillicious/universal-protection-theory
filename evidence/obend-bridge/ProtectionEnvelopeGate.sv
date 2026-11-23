module ProtectionEnvelope (
  input  logic        clk,
  input  logic        rst,
  input  logic [63:0] arg,
  output logic [63:0] out_holdFloor,
  output logic [63:0] out_slashPenalty,
  output logic [63:0] out_coopSynergy,
  output logic [63:0] out_predationGain,
  output logic [63:0] out_committeeSize,
  output logic [63:0] out_quorumThreshold,
  output logic [63:0] out_netDeviationSlack
);
  logic [63:0] w_0; // holdFloor
  logic [63:0] w_1; // slashPenalty
  logic [63:0] w_2; // coopSynergy
  logic [63:0] w_3; // predationGain
  logic [63:0] w_4; // committeeSize
  logic [63:0] w_5; // quorumThreshold
  logic [63:0] w_6; // netDeviationSlack
  logic [63:0] reg_holdFloor;
  logic [63:0] reg_slashPenalty;
  logic [63:0] reg_coopSynergy;
  logic [63:0] reg_predationGain;
  logic [63:0] reg_committeeSize;
  logic [63:0] reg_quorumThreshold;
  logic [63:0] reg_netDeviationSlack;
  always_comb begin
    w_0 = (64'd1 + 64'd1);
    w_1 = 64'd60;
    w_2 = 64'd20;
    w_3 = 64'd50;
    w_4 = ((arg * 64'd3) + 64'd1);
    w_5 = ((arg * 64'd2) + 64'd1);
    w_6 = ((((w_2 + w_1) < w_3 ? 64'd1 : 64'd0) != 64'd0) ? 64'd0 : ((w_2 + w_1) - w_3));
    out_holdFloor = w_0;
    out_slashPenalty = w_1;
    out_coopSynergy = w_2;
    out_predationGain = w_3;
    out_committeeSize = w_4;
    out_quorumThreshold = w_5;
    out_netDeviationSlack = w_6;
  end
  // Reset-free datapath registers
  always_ff @(posedge clk) begin
    reg_holdFloor <= w_0;
    reg_slashPenalty <= w_1;
    reg_coopSynergy <= w_2;
    reg_predationGain <= w_3;
    reg_committeeSize <= w_4;
    reg_quorumThreshold <= w_5;
    reg_netDeviationSlack <= w_6;
  end
endmodule
