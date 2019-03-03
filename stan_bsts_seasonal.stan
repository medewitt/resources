// From https://discourse.mc-stan.org/t/bayesian-structural-time-series-modeling/2256


functions {
  // This function from http://tharte.github.io/mbt/mbt.html#sec-3-9-2
    real sum_constraint(vector x, int t, int Lambda) {
		int t_start;
		int t_end;
        real s;
		s=  0;

		// wind back from: (t-1)  to:  t-(Lambda-1)
		t_start= t-1;
		t_end=   t-(Lambda-1);

		for (i in t_start:t_end) {
		    s= s - x[i];
		}

        return s;
	}
}


data {
  int <lower=0> t; // number of observations
  int <lower=1> K; // number of predictors 
  matrix[t, K] x; // predictors
  vector[t] y; // outcomes
  int <lower=1> Lambda; // seasonality
}

parameters {
  vector[t] u_err; //Slope innovation
  vector[t] v_err; //Level innovation
  vector[t] s; // seasonality
  vector[K] beta;
  real <lower=0> s_obs;
  real <lower=0> s_slope;
  real <lower=0> s_level;
  real <lower=0> s_season;
}

transformed parameters {
  vector[t] u; //Level
  vector[t] v; //Slope
  vector[t] ss;
  u[1] = u_err[1];
  v[1] = v_err[1];
  for (i in 2:t) {
    u[i] = u[i-1] + v[i-1] + s_level * u_err[i];
    v[i] = v[i-1] + s_slope * v_err[i];
  }
  
    for (i in 1:(Lambda-1)) {
        ss[i]= 0;
    }

	for (i in Lambda:t) {
	    ss[i]= 0;
		for (lambda in 1:(Lambda-1)) {
			ss[i]= ss[i] - s[i-lambda];
		}
	}

}

model {
  u_err ~ normal(0,1);
  v_err ~ normal(0,1);
  
  for (i in Lambda:t) {
        s[i] ~ normal(ss[i], s_season);
    }
  
  y ~ normal (x*beta + u + s, s_obs); // model
}





