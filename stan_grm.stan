// adpated from Daniel Furr 
// Here https://groups.google.com/forum/#!msg/stan-users/viQXrMU7vU0/zlGhan1wBQAJ
data {
  int<lower=1> I;                // # items
  int<lower=1> J;                // # persons
  int<lower=1> N;                // # responses
  int<lower=1,upper=I> ii[N];    // i for n (item id)
  int<lower=1,upper=J> jj[N];    // j for n (person id)
  int<lower=0> y[N];             // response for n; y in {0 ... m_i}
}
transformed data {
  int r[N];                      // modified response; r = 1, 2, ... m_i + 1
  int m[I];                      // # difficulty parameters per item
  int pos_kappa[I];              // first position in kappa vector for item
  int pos_delta[I];              // first position in delta vector for item
  m = rep_array(0, I);
  for(n in 1:N) {
    r[n] = y[n] + 1;
    if(y[n] > m[ii[n]]) m[ii[n]] = y[n];
  }
  pos_kappa[1] = 1;
  pos_delta[1] = 1;
  for(i in 2:(I)) {
    pos_kappa[i] = pos_kappa[i-1] + m[i-1];
    pos_delta[i] = pos_delta[i-1] + m[i-1] - 1;
  }
}
parameters {
  vector[I] mu;                    // First diffulty for each item
  vector<lower=0>[sum(m)-I] delta; // Between-step changes in difficulty
  real theta[J];                   // Ability
  real<lower=0> alpha[I];          // Discrimination
}
transformed parameters {
  vector[sum(m)] kappa;            // Composite item difficulties
  for(i in 1:I) {
    for(k in 1:m[i]) {
      if(k == 1) {
        kappa[pos_kappa[i]] = mu[i];
      }
      if(k > 1) {
        kappa[pos_kappa[i]+k-1] = kappa[pos_kappa[i]+k-2] +
          delta[pos_delta[i]+k-2];
      }
    }
  }
}
model {
  theta ~ normal(0,1);
  alpha ~ lognormal(1, 1);
  delta ~ normal(0,5);
  mu ~ normal(0,5);
  for (n in 1:N) {
    r[n] ~ ordered_logistic(theta[jj[n]] * alpha[ii[n]],
      segment(kappa, pos_kappa[ii[n]], m[ii[n]]));
  }
}

