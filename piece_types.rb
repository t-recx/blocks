class PieceTypes
  T_BLOCK = [[[-1, 0], [0, 0], [1, 0], [0, -1]],
              [[-1, 0], [0, 0], [0, -1], [0, 1]],
              [[-1, 0], [0, 0], [1, 0], [0, 1]],
              [[1, 0], [0, 0], [0, 1], [0, -1]]]

  I_BLOCK = [[[-2, 0], [-1, 0], [0, 0], [1, 0]],
              [[0, 0], [0, 1], [0, 2], [0, 3]]]

  O_BLOCK = [[[-1, 0], [0, 0], [-1, 1], [0, 1]]]

  J_BLOCK = [[[-2, 0], [-1, 0], [0, 0], [0, 1]],
              [[0, 0], [0, 1], [0, 2], [-1, 2]],
              [[-2, 0], [-2, 1], [-1, 1], [0, 1]],
              [[-1, 0], [-1, 1], [-1, 2], [0, 0]]]
  
  L_BLOCK = [[[-2, 1], [-1, 1], [0, 1], [0, 0]],
              [[-1, 0], [-1, 1], [-1, 2], [0, 2]],
              [[-2, 0], [-1, 0], [0, 0], [-2, 1]],
              [[0, 0], [0, 1], [0, 2], [-1, 0]]]

  S_BLOCK = [[[-1, 1], [0, 1], [0, 0], [1, 0]],
              [[0, 0], [0, 1], [1, 1], [1, 2]]]

  Z_BLOCK = [[[-1, 0], [0, 0], [0, 1], [1, 1]],
              [[0, 0], [0, 1], [-1, 1], [-1, 2]]]

  BLOCKS = [T_BLOCK, I_BLOCK, O_BLOCK, J_BLOCK, L_BLOCK, S_BLOCK, Z_BLOCK]
end
