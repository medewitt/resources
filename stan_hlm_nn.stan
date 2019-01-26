// Normal Normal Model

data {
  int<lower=0> J;   // number of data items
  int<lower=0> I;   // number of predictors
  vector[J] x; // depdent variable
  matrix[J, I] y;   // predictor matrix
}
parameters {
  vector[I] beta0; //vector of beta0s
  vector[I] beta1; //vector of beta1s
  real mu_beta0; //average value of beta0
  real mu_beta1; //average value of beta1
  real tau;
  real tau_beta1;
  real tau_beta0;
  
}

transformed parameters{
  real xbar;
  xbar = mean(x); // calculate the average value of x
  
}
model {
  // priors
  tau ~ gamma(.01, .01); 
  mu_beta0 ~ normal(0, 10);
  tau_beta0 ~ gamma( .01, .01);
  mu_beta1 ~ normal(0, 10);
  tau_beta1 ~ gamma( .01, .01);
  
  //group effects for each indicator
  for(i in 1:I){
  beta0[i] ~ normal(mu_beta0, tau_beta0);
  beta1[i] ~ normal(mu_beta1, tau_beta1);
  }
  
  //model
  for(j in 1:J){
    y[j]~ normal(beta0 + beta1*(x[j]-xbar), tau);
  }
  
}
