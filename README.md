FRF_ansys_mat
=============

从ansys中导出节点频响，在matlab中处理

1.在ansys中进行谐响应分析，选择所有关心的节点，使用“output”导出其频响数据
2.在“avg_vib_lev”中处理频响数据，得到各测点的总振级和平均振级
3.使用“Comp2Fig”将两个fig合并成一个，比较不同模型的频响曲线
