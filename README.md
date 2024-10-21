# Benchmark rails against other framework

The goal of this project is to check how Ruby on Rails
performs compared to other web framework.

## Motivation

The motivation behind this project is, that there are many
false or exaggerated assumptions that are circulating though the
internet about rails performance. Many of them are caused on
badly made performance benchmarks. I have seen the following cases
in my > 8 years as a web developer:
* Some developers use performance metrics in the logs instead
  of an external tool to check real performance. Using performance
  logs are fine to debug problems in your code but not good to
  compare frameworks because some of them maybe include more stuff
  than others.
* Some developers make benchmark against development environment,
  instead production ones, where rails performs very differently. 
* In some rails deployments rails concurrency is not correctly
  configured.

# How to benchmark

Every framework is deployed to a real server (hetzner) using kamal. Then the benchmark
using `wrk -t12 -c400 -d30s <my_domain.com>` is used to perform the benchmark. Here it
is important to set correctly WEB_CONCURRENCY under `rails_benchmark/config/deploy.yml`. 

# Benchmark results:

The benchmarks was made against the hetzner server of type CX22 that has 2 VCPU and
4GB ram. 

Root path without any database call (Path: /):
* Ruby on Rails: 282 requests/second
* Phoenix/Elixir: 672 requests/second

Path with database call to an empty table (Path: /users):
* Ruby on Rails: 281 requests/second 
* Phoenix/Elixir: 392 requests/second

Path with database call to an table with one entry (Path: /users):
* Ruby on Rails: 257 requests/second 
* Phoenix/Elixir: 354 requests/second

NOTE: I will add more benchmarks here.
