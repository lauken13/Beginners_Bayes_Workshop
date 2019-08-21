data {
  int<lower=1> N;
  int<lower=0> complaints[N];
  vector<lower=0>[N] traps;
  vector[N] log_sq_foot;
  int<lower=0> J; //Number of buildings
  int<lower=0> K; //Number of building level predictors
  int<lower=0, upper=J> building_idx[N];
  matrix[J,K] building_data;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> inv_phi;
  vector[J] mu;
  vector[K] zeta;
  real<lower=0> sigma_mu;
}
transformed parameters {
  vector[N] eta =
    mu[building_idx] +
    beta * traps +
    log_sq_foot;
  real phi = 1 / inv_phi;
}
model {
  // create temporary variable eta that includes the new predictors
  mu ~ normal(alpha + building_data * zeta, sigma_mu);
  complaints ~ neg_binomial_2_log(eta, phi);
  alpha ~ normal(log(7), 1);
  beta ~ normal(-0.25, 0.5);
  inv_phi ~ normal(0, 1);
  zeta ~ normal(0,1);
  sigma_mu ~ normal(0,1);

}
generated quantities {
  int y_rep[N];
  for (n in 1:N) {
    y_rep[n] = neg_binomial_2_log_rng(eta[n], phi);
  }
}
