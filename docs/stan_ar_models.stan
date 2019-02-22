// From https://mc-stan.org/docs/2_18/stan-users-guide/autoregressive-section.html
// Allowing for flexible autoregression for time series modeling

data {
  int<lower=0> K;  // Order of Autoregression
  int<lower=0> N; // number of observations
  real y[N];      // Outcome
}
parameters {
  real alpha;
  real beta[K];
  real sigma;
}
model {
  for (n in (K+1):N) {
    real mu = alpha;
    for (k in 1:K)
      mu += beta[k] * y[n-k];
    y[n] ~ normal(mu, sigma);
  }
}
