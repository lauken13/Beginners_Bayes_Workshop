data {
  int<lower=1> N;
  int<lower=0> complaints[N];
  vector<lower=0>[N] traps;
}
parameters {
  real alpha;
  real beta;
}
transformed parameters {
  // could declare 'eta' here if we want to save it 
}
model {
  // poisson_log(x) is more efficient and stable alternative to poisson(exp(x))
  complaints ~ poisson_log(alpha + beta * traps);
  
  // weakly informative priors:
  // we expect negative slope on traps and a positive intercept,
  // but we will allow ourselves to be wrong
  beta ~ normal(-0.25, 0.5);
  alpha ~ normal(log(7), 1);
} 
generated quantities {
  int y_rep[N];

  for (n in 1:N) {
    real eta_n = alpha + beta * traps[n];
    if (eta_n >= 20.79) eta_n = 20.79;
    y_rep[n] = poisson_log_rng(eta_n); 
  }
}
