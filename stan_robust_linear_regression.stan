// linear regression
data {
  int<lower=0> N; //number of samples
  vector[N] x; //independent variable
  vector[N] y; // depdent variable
  real<lower=0> nu; //degrees of freedom
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  y ~ student_t(nu, alpha + beta * x, sigma);
}

