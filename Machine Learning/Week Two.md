# Linear Regression with Multiple Virables
## Multiple Features
多变量线性函数可以定义为：
$$ h_{\theta(x)} = \theta_{0} + \theta_1 x_1 + \theta_2 x_2 + ... + \theta_n x_n$$

如果把参数和变量用矩阵来表示，假设$x_0 = 1$,则$h_{(\theta)}可以变成：
$$ 
\left\{
\begin{matrix}
x_0 \\ x_1 \\ x_2 \\ x_3 \\ ... \\ x_n
\end{matrix}
\right\}
*
\left\{
\begin{matrix}
\theta_0 && \theta_1 && \theta_2 && \theta_3 && ... && \theta_n
\end{matrix}
\right\}
\tag 1
$$
$$ h_{\theta(X)} = \theta^T * X $$

## Gradient Descent for Multiple Variables
$$ \theta_j = \theta_j - \alpha \frac{1}{m}\sum^m_{i=1}(h_{(\theta)}(x^{(i)} - y^{(i)})x^{(i)}  $$
## Gradient Descent in Practice
如果变量的取值非常大，梯度下降算法就需要花非常长的时间来找到全局最低点，所以可以使用一些方法来缩短时间。
* feature scaling 
特征收缩是为了将特征的取值缩小到-1 到 1 之间，大一点和小一点都不影响，只是粗略取值。使用 $\theta$ 除以$\theta$的取值范围，也就是最大值减去最小值。 
* mean normalization
使用变量减去变量的平均值，是新的平均值接近于0。

$$x_i = \frac{x_i-\mu_i}{s_i}$$

$\mu_i$就是均值归一减去的平均值，$s_i$就是特征收缩除去的变量范围。
## Features and Polynomial Regression

#Computing Parameters Analytically
## Normal Equation
## Normal Equation Noninvertibility

# Submitting Pragramming Assignments
## Working on and Submitting Programming

# Octave Tutorial

