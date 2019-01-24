// linear regression
data {
  int<lower=0> N; //number of samples
  vector[N] x; //independent variable
  vector[N] y; // depdent variable
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  y ~ normal(alpha + beta * x, sigma);
}
