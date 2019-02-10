//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;  // number of data points
  int<lower=1> J;  //parameters
  matrix[N, J] y;  //outputs
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  //latent variables
  matrix [N, J] mu;
  vector[N] xistar;
  vector[N] sd_xistar;
  vector[N] xi;
  
  vector[J] gamma_0;
  vector[J] gamma_1;
  vector[J] tau;
  
  
  //
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  //latent variables
  real mu_xistar;
  //real xi;
  
  mu_xistar = mean(xistar);
  for( n in 1:N){
    xistar[n] ~normal(0,1);
    xi = (xistar-mu_xistar) / sd_xistar;
  }
  

  
  //priors for measurement parameters
  for(j in 1:J){
    gamma_0[j] ~ normal(0, 10);
    gamma_1[j] ~ normal(0, 10);
    tau ~ gamma( 0.1, 0.1);
    mu = gamma_0[j] + gamma_1[j]*xi;
  }
  //model

  
  y ~ normal(mu, tau);
}

