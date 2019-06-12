# 文件数据
## desc
###  ave
+   import numpy as np
+   np.average(np.array(x))
###  fivenum of columns
+   import pandas as pd
+   my_df['col'] = my_df['col'].astype(np.float64)
+   bins_col = pd.qcut(my_df['col'],4)
+   bins_col_label = pd.qcut(my_df['col'],4).labels
### group summarise
+   aggregated_values = my_df.groupby('col_0')['col_1'].agg(['mean','max'])
+   def my_func(my_group_array): return my_group_array.min()*my_group_array.count()
+   aggregated_values = my_df.groupby(['col_0'])['col_1'].agg([my_func])