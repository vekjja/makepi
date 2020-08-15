#!/bin/bash


helm upgrade --install nginx-test chart --values values.yaml --namespace test

