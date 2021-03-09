# 常见排序算法的C++模板函数实现



## 各排序算法的特点

- 选择排序：速度慢，常数空间复杂度，不稳定排序，算法简单，适用于小规模排序；
- 冒泡排序、简单插入排序、折半插入排序：速度慢（平均时间复杂度为$O(n^2)$），常数空间复杂度，稳定排序，算法简单，适用于小规模排序；
- 希尔排序、快速排序、堆排序：速度较快（平均时间复杂度为$O(n \log n)$），空间复杂度不高，不稳定排序，适用于大规模排序；
- 归并排序、桶排序：速度较快，空间复杂度高，稳定排序，适用于大规模排序；
- 计数排序、基数排序：速度快，空间复杂度高，稳定排序，适用于大规模整数排序或字典排序；



基于元素比较的排序算法：选择排序、冒泡排序、简单插入排序、折半插入排序、希尔排序、快速排序、堆排序、归并排序；

基于分配收集的排序算法：桶排序（但桶内排序仍基于元素比较）、计数排序、基数排序；



## 各排序算法测试结果（单位：秒）

测试硬件：Dell XPS13 9343-1708, i7-5500U, 8GB

系统信息：Linux bufbrane 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

编译器版本：gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0

编译命令：`gcc main.cpp -lstdc++ -O3`

计时工具：Linux自带的time命令



|           Algorithm          | 100K, asc | 100K, desc | 100K, random | 1M, asc | 1M, desc | 1M, random | 10M, random | 100M, random |
|:----------------------------:|:-------:|:--------:|:----------:|:--:|:--:|------------------------------|------------------------------|------------------------------|
|          bubble_sort         |    3.80   |   23.14    |    18.15     | \*\*\*\* | \*\*\*\* | \*\*\*\* | \*\*\*\* | \*\*\*\* |
|        selection_sort        |    3.80   |   11.77    |     3.78     | \*\*\*\* | \*\*\*\* | \*\*\*\* | \*\*\*\* | \*\*\*\* |
|        insertion_sort        |    1.99   |    0.96    |     2.26     | 218.78 | 131.93 | 254.89 | \*\*\*\* | \*\*\*\* |
| binary_search_insertion_sort |    0.01   |    0.92    |     0.43     |   0.08  | 125.82 | 56.28 | \*\*\*\* | \*\*\*\* |
|          shell_sort          |    0.08   |    0.08    |     0.09     |   1.16  |   1.19   |    1.37    | 27.86 | \*\*\*\* |
|           heap_sort          |    0.01   |    0.01    |     0.01     |   0.06  |   0.06   |    0.18    | 2.94 | 46.19 |
|          merge_sort          |    0.01   |    0.01    |     0.01     |   0.04  |   0.06   |    0.14    | 1.69 | 21.89 |
|          quick_sort          |   0.00\*  |   0.01\*   |     0.01     |  0.09\* |  0.08\*  |    0.10    | 1.17 | 13.41 |
|         counting_sort        |    0.01   |    0.01    |     0.00     |   0.00  |   0.01   |    0.02    | 0.32 | 3.79 |
|        bucket_sort\*\*       |    0.01   |    0.01    |     0.01     |  0.15  |   0.18   |    0.24    | 6.68 | 146.58 |
|          radix_sort          |    0.02   |    0.02    |     0.02     |   0.15  |   0.15   |    0.24    | 2.83 | 36.92 |
| std::sort()\*\*\* | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 | 0.94 | 10.54 |
| std::stable_sort()*** | 0.00 | 0.00 | 0.00 | 0.02 | 0.02 | 0.10 | 1.10 | 14.51 |



注：

- 100K、1M、10M、100M为排序元素个数，asc为初始升序，desc为初始降序，random为初始随机序列。
- 测试方法：运行三次，求平均运行时间，再减去测试数据的装填时间。同一类型的测试装填相同的数据。

- 测试数据属性：随机数据由C语言随机函数`rand()`生成，并设置`srand(0)`以保证测试数据集相同；不同数量的数据集同分布（生成的n个数据，其值域为[0, n-1]）。升序数据由C++的STL算法`std::sort()`对前者生成的随机数排序得到，降序数据则在升序数据的基础上使用C++的STL算法`std::reverse()`得到。



---

\* : 快速排序算法参考了C++的std::sort()的思想，当递归栈过深时采用堆排序以避免性能恶化。

\*\* : 桶排序算法设置为平均每个桶装128个元素，桶内排序使用折半插入排序。

\*\*\* : 列出了C++STL排序函数`std::sort()`和`std::stable_sort()`的数据作为参考。

\*\*\*\* : 预估运行时间超过五分钟，没有测试的必要了。