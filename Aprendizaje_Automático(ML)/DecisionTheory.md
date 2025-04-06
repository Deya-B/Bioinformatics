### 1. Introduction to Decision Theory

Decision theory helps formalize how to make optimal decisions under uncertainty, especially important in probabilistic models and machine learning. It involves choosing actions that minimize expected loss or maximize expected utility.

---

### Components of Decision Theory

- **Actions** \(a \in A\): Possible decisions we can make.
- **States of nature** \(\theta \in \Theta\): The true conditions, usually unknown.
- **Loss function** \(L(a, \theta)\): Quantifies the cost of choosing action \(a\) when the true state is \(\theta\).
- **Risk function** \(R(a, \theta)\): Expected loss over data drawn from a distribution depending on \(\theta\).
  

### Decision Rules
A **decision rule** is a function \(\delta\) that maps observed data \(x\) to an action:  
\[
\delta(x) = a
\]

The **risk of a decision rule** is:
\[
R(\theta, \delta) = \mathbb{E}_{x \sim p(x|\theta)}[L(\delta(x), \theta)]
\]


### Bayesian Decision Theory

In the Bayesian framework:
- We assume a prior distribution over \(\theta\): \(p(\theta)\)
- The **Bayes risk** is the expected risk under the prior:
\[
r(\delta) = \mathbb{E}_{\theta}[R(\theta, \delta)] = \int R(\theta, \delta) p(\theta) d\theta
\]

The **Bayes decision rule** \(\delta^*\) minimizes this Bayes risk.


### Posterior Predictive Decision Making
Often we use the **posterior** over \(\theta\) given data \(x\) to choose the best action:
\[
\delta^*(x) = \arg\min_{a} \mathbb{E}_{\theta \sim p(\theta | x)} [L(a, \theta)]
\]

This is the essence of **Bayesian decision theory**: act to minimize expected loss based on the posterior distribution.


### Common Loss Functions

- **0-1 loss**: Used in classification, loss is 0 for correct classification, 1 otherwise.
- **Squared loss**: Common in regression; penalizes large errors more.
- **Absolute loss**: Linear penalty; more robust to outliers.

### Applications in Machine Learning
- **Classification**: Choose label with highest posterior probability (MAP estimate under 0-1 loss).
- **Regression**: Predict the posterior mean (minimizes squared loss), or median (for absolute loss).
- **Model selection**: Decision theory helps choose models that balance accuracy and complexity (via expected utility or risk).

