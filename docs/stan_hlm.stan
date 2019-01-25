//hierarchical linear model

data{
  int<lower=0> J;          //number of schools
  real y[J];              //treatment effect for each school
  real<lower=0>sigma[J]; //s.e. of effects
}

parameters{
  real mu; //population mean
  real<lower=0> tau; //population sd
  vector[J] eta; //school-level error
}

transformed parameters{
  vector[J] theta;  //school effect
  theta = mu + tau*eta;
}

model{
  eta ~ normal(0,1);
  y~normal(theta, sigma);
}

