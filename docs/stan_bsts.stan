// From https://discourse.mc-stan.org/t/bayesian-structural-time-series-modeling/2256

data {

  int <lower=0> t; // number of observations
  int <lower=1> K; // number of predictors 
  matrix[t, K] x; // predictors
  vector[t] y; // outcomes
}

parameters {
  vector[t] u_err; //Slope innovation
  vector[t] v_err; //Level innovation
  vector[K] beta;
  real <lower=0> s_obs;
  real <lower=0> s_slope;
  real <lower=0> s_level;
}

transformed parameters {
  vector[t] u; //Level
  vector[t] v; //Slope
  u[1] = u_err[1];
  v[1] = v_err[1];
  for (i in 2:t) {
    u[i] = u[i-1] + v[i-1] + s_level * u_err[i];
    v[i] = v[i-1] + s_slope * v_err[i];
  }
}

model {
  u_err ~ normal(0,1);
  v_err ~ normal(0,1);
  
  y ~ normal (x*beta + u, s_obs); //u
}





