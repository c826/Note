# What is Machine Learning


机器学习不存在一个被广泛认可的定义，来准确定义机器学习是什么或者不是什么。一个比较久远的定义是：
	
```
	Arthur Samuel : " the field of study that gives computers the ability to learn without being explicitly programmed ".
```
	
Arthur 定义机器学习为：能让机器通过学习来或者某种能力，而并不需要去编写指定的代码。
	
另一个相对现代一点的定义是：
	
```
	Tom Mitchell : " A computer program is said to learn from experience E with respect to some class of tasks T and performance measure P, if its performance at tasks in T, as measured by P, improves with experience E.
```

Tom 认为：计算机程序遵循某个类型的任务T,来学习经验E，并且用P来评估性能。在任务T中用P来评估的性能，通过E来提升。

通常来说机器学习可以被分为两种类型：

* 监督式学习( Supervised learning)
* 非监督式学习(Unspuervised learning)

## Supervise Learning

在监督式学习中，我们给定一个数据集并且已经知道正确输出应该是什么样的，并且猜想输入和输出之间存在一种对应关系。

监督式学习问题可以分为两种:

* 回归问题 ( Regression problems)
* 分类问题 ( Classification problems)

回归问题中，我们尝试在连续的输出中来预测结果，这意味着我们试图将输入变量映射到某些连续的函数当中去。比如：给定一张人的图片，基于图片来预测图片中人的年龄。年龄是一段连续的输出结果，所以是回归问题。

分类问题中，我们试图在不相关的输出中来预测结果，换句话来说就是我们试图将输入的变量映射到不相关的分类当中。例如：给一个患有肿瘤的病人信息，来预测这个肿瘤是良性的还是恶性的。肿瘤良性和恶性是相对的两种结果，所以这个划分为分类问题。

## Unsupervised Learning

非监督是学习可以让我们来解决我们并不知道输出结果应该是什么的问题。我们不需要知道输入变量的结果就能从数据中得到函数结构。我们可以通过数据中的变量关系来聚类数据，从而得到函数结构。使用非监督式学习的预测结果不会有任何反馈。

# Linear Regression with One Variable
## Model Representation

* $ x^{(i)}$  表示输入变量(input variables，**features**)
* $ y^{(i)}$  表示输出变量(output variables, **target**)
* $(x^{(i)} , y^{(i)})$ training example
* $h_\theta = \theta_0 + \theta_1*x$ called **hypothesis**

## Cost Function
我们使用造价函数(**Cost Function**)来评估我们的假设函数(**Hypothesis Functions**)。

$$J_(\theta1,\theta2) = \frac{1}{2m} \sum_{i=1}^m(h_\theta(x_i) - y_i)^2$$

造价函数也称为平方误差函数(squared error funcion)或者均方误差(Mean squared error),就是预测的结果$h_\theta(x_i)$与实际样本结果$y_i$的平方差之和。$\frac{1}{2}$是为了方便梯度下降计算。

## Cost Function Intuition 

**最小化造价函数，就是找到了与实际函数误差最小的假设函数**

## Gradient Descent

梯度下降算法，是用来估算假设函数中参数的方法。

$$ \theta_j = \theta_j - \alpha \frac{\delta}{\delta\theta_j}J(\theta_0,\theta_1)$$

梯度下降函数，根据在点$(\theta_0, \theta_1)$处的偏导数来确定移动方向，$\alpha$表示每次移动的具体，成为学习速率(learning rate)。

**因为梯度下降函数的目的是找到函数的最小值，所以当偏导数为正数时往负方向移动，偏导数为负数时往正方向移动。直到偏导数为0时不再移动，也就是找到了最低点。**

梯度下降算法需要同时更新$\theta_0 和 \theta_1$。

$$temp0 = \theta_0 - \alpha\frac{\delta}{\delta\theta_0}J(\theta_0,\theta_1) \tag1$$
$$temp1 = \theta_1 - \alpha\frac{\delta}{\delta\theta_1}J(\theta_0,\theta_1) \tag2$$
$$\theta_0 = temp0\tag3$$
$$\theta_1 = temp1\tag4$$

## Grandient Descent Intuition

**梯度下降算法关键需要选定一个合适的$\alpha$，$\alpha$太小会导致计算时间增加，速度过慢。$\alpha$太大有可能会找不到最低点。**

## Grandient Descent For Linear Regression

我们可以将线性回归方程带入梯度下降算法的倒数部分$\frac{\delta}{\delta\theta_j}J(\theta_0,\theta_1)$可以得出：
$$ \theta_0 = \theta_0 - \alpha\frac{1}{m}\sum_{i=1}^{m}(h_\theta(x_i) - y_i) \tag1 $$
$$ \theta_1 = \theta_1 - \alpha\frac{1}{m}\sum_{i=1}^{m}((h_\theta(x_i)-y_i)x_i) \tag2$$

* $\theta_0 \theta_1$ 是虚构函数的参数
* $x_i y_i$ 是训练数据集中的数据

# Linear Algebra Review
## Matrices and Vectors
矩阵(Matrix) 3 * 2

$$ 
\left\{
\begin{matrix}
	1 & 2 \\ 3 & 4 \\ 5 & 6
\end{matrix}
\right\} 
$$

三维向量 (1-dimensional vectors) 或者 R 1 * 3 矩阵

$$
\left\{
\begin{matrix}
	1 \\ 2 \\ 3
\end{matrix}
\right\}
$$


## Addition and Scalar Multiplication

* 矩阵加减法

$$
\left\{
\begin{matrix}
	12 & 13 & 14 \\  11 &  1 & 0 \\ 18 & 21 & 3
\end{matrix}
\right\}  + 
\left\{
\begin{matrix}
	1 & 2 & 3\\ 2 & 4 & 5 \\ 3 & 6 & 7
\end{matrix}
\right\}  = 
\left\{
\begin{matrix}
	13 & 15 & 17 \\  13 & 5 & 5 \\ 21 & 27 & 10
\end{matrix}
\right\}
$$

$$
\left\{
\begin{matrix}
	12 & 13 & 14 \\  11 &  1 & 0 \\ 18 & 21 & 3
\end{matrix}
\right\}  - 
\left\{
\begin{matrix}
	1 & 2 & 3\\ 2 & 4 & 5 \\ 3 & 6 & 7
\end{matrix}
\right\}  = 
\left\{
\begin{matrix}
	11 & 11 & 11 \\  9 & -3 & -5 \\ 15 & 15 & -4
\end{matrix}
\right\}
$$

**只有相同维度的矩阵才能相加或者相减，两个矩阵中对应的数据相加或者相减**


* 矩阵标量乘除法

$$
\left\{
\begin{matrix}
	12 & 13 & 14 \\  11 &  1 & 0 \\ 18 & 21 & 3
\end{matrix}
\right\}  * 3 = 
\left\{
\begin{matrix}
	36 & 39 & 42 \\  33 & 3 & 0 \\ 54 & 63 & 9
\end{matrix}
\right\}
$$

$$
\left\{
\begin{matrix}
	12 & 15& 18 \\  3 &  6 & 9 \\ 18 & 21 & 3
\end{matrix}
\right\}  / 3 = 
\left\{
\begin{matrix}
	4 & 5 & 6 \\  1 & 2 & 3 \\ 6 & 7 & 3
\end{matrix}
\right\}
$$

**将矩阵中所有数据都乘以或者除以对应的数字**

## Matrix Vector Multiplication
* 矩阵 * 向量
$$
\left\{
\begin{matrix}
	12 & 13 & 14 \\  11 &  1 & 0 \\ 18 & 21 & 3
\end{matrix}
\right\}  *
\left\{
\begin{matrix}
	1 \\ 2 \\ 3
\end{matrix}
\right\}  = 
\left\{
\begin{matrix}
	12 * 1 + 13 * 2 + 14 * 3 \\ 11 * 1 + 1 * 2 + 0 * 3 \\ 18*1 + 21 * 2 + 3 * 3
\end{matrix}
\right\}
$$

**m x n矩阵  X   n维向量  =   m x 1矩阵**
**要乘的向量的维度必须等于矩阵的列数。也就是两个n必须相等。**

## Matrix Matrix Multiplication

* 矩阵与矩阵乘法

 $$
\left\{
\begin{matrix}
	2 & 3 \\  1 & 0 
\end{matrix}
\right\}  *
\left\{
\begin{matrix}
	1  & 2 \\ 3 & 4
\end{matrix}
\right\}  = 
\left\{
\begin{matrix}
	2 * 1 + 3 * 3 & 2 * 2 + 3 * 4 \\
	1 * 1 + 0 * 3  & 1 * 2 + 0 * 4
\end{matrix}
\right\}
$$

**m x n 矩阵  X  n x o 矩阵 = m x o 矩阵**
**n 与 n 必须相等**
## Matrix Multiplication Properties
## Inverse and Transpose



	
	
	











