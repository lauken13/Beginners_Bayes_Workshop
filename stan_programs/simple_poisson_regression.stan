data {

}
parameters {

}
transformed parameters {
  // could declare 'eta' here if we want to save it 
}
model {
  // poisson_log(x) is more efficient and stable alternative to poisson(exp(x))
  
  // weakly informative priors:
  // we expect negative slope on traps and a positive intercept,
  // but we will allow ourselves to be wrong

} 
generated quantities {

}
