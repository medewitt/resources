// 2PL IRT in Stan
// Modified from the Stan Users Guide <https://mc-stan.org/docs/>
data {
  int<lower=1> J;              // number of students
  int<lower=1> K;              // number of questions
  int<lower=1> N;              // number of observations
  int<lower=1,upper=J> jj[N];  // student for observation n
  int<lower=1,upper=K> kk[N];  // question for observation n
  int<lower=0,upper=1> y[N];   // correctness for observation n
}

parameters {
  real mu_beta;                // mean question difficulty
  vector[J] alpha;             // ability for j - mean
  vector[K] beta;              // difficulty for k
  vector<lower=0>[K] gamma;    // discrimination of k
  //real<lower=0> sigma_beta;    // scale of difficulties
  //real<lower=0> sigma_gamma;   // scale of log discrimination
}

model {
  alpha ~ std_normal(); // normal(y| 0,1)
  //Can make these hierarchical priors if desired
  //beta ~ normal(0, sigma_beta);
  //gamma ~ lognormal(0, sigma_gamma);
  beta ~ normal(0, 5);
  gamma ~ lognormal(0, 2);
  mu_beta ~ cauchy(0, 5);
  //sigma_beta ~ cauchy(0, 5);
  //sigma_gamma ~ cauchy(0, 5);
  y ~ bernoulli_logit(gamma[kk] .* (alpha[jj] - (beta[kk] + mu_beta)));
}

