// adapted from 

functions {

  /**
   * class_prob
   *
   * Given an array of responses and probabilities for each response
   *  for class 0 and class 1, calculate the probability that each
   *  respondent is in class 0 via Bayes rule. In the training set,
   *  the actual class of respondent `i` is given by `y[i]`.
   *
   * We assume that responses to different questions are independent
   *  and that each class is equally likely. That is, we take
   *  P(y=1) = P(y=0) = 0.5, and thus these terms cancel.
   *
   * @param R A 2-array of integers, where each row corresponds to a
   *  a respondent, and each column corresponds to a question. Elements
   *  can be 1, 2, ..., A.
   *
   * @param theta_0 A 2-array of response probabilities for class 0.
   *  That is, `theta_0[q, r]` is the probability of (integer-valued)
   *  response `r` to question number `q`.
   *
   * @param theta_1 A 2-array of response probabilities for class 1.
   *
   * @return A vector of probabilities that each user is in class 0.
   *  This vector has the same number of elements as there are rows
   *  in R.
   */
   
  // note the type signatures here!
  vector class_prob(int[,] R, vector[] theta_0, vector[] theta_1) {

    real p_0;
    real p_1;

    int N = dims(R)[1];
    int Q = dims(R)[2];

    vector[N] p;

    for (i in 1:N) {
    
      vector[Q] pr_0;
      vector[Q] pr_1;

      for (q in 1:Q) {

        pr_0[q] = theta_0[q, R[i, q]];
        pr_1[q] = theta_1[q, R[i, q]];

      }

      // take the product of probabilities across all questions
      // since we assume responses to different questions are
      // independent. work in log space for numerical stability

      p_0 = exp(sum(log(pr_0)));
      p_1 = exp(sum(log(pr_1)));

      p[i] = p_0 / (p_0 + p_1);
    }

    return(p);
  }
}

data {
  int Q;      // number of questions
  int A;      // number of possible answers to each question

  int N;      // number of respondents
  int new_N;  // number of unlabelled respondents

  int<lower=1, upper=5> R[N, Q];          // responses to questions (train)
  int<lower=1, upper=5> new_R[new_N, Q];  // responses to questions (test)

  int<lower=0, upper=1> y[N];             // binary feature for user

  vector<lower=0>[A] alpha;               // dirichlet prior parameter
}

parameters {
  // response probabilities for each question
  simplex[A] theta_0[Q];  // for group 0
  simplex[A] theta_1[Q];  // for group 1
}

model {

  for (q in 1:Q) {

    theta_0[q] ~ dirichlet(alpha);
    theta_1[q] ~ dirichlet(alpha);

    for (i in 1:N) {

      if (y[i] == 0) {
        R[i, q] ~ categorical(theta_0[q]);
      }

      if (y[i] == 1) {
        R[i, q] ~ categorical(theta_1[q]);
      }
    }
  }
}

generated quantities {
  vector[N] pred = class_prob(R, theta_0, theta_1);
  vector[new_N] new_pred = class_prob(new_R, theta_0, theta_1);
}

