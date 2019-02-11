docker build -t acovid/multi-client:latest -t acovid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t acovid/multi-server:latest -t acovid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t acovid/multi-worker:latest -t acovid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push acovid/multi-client:latest
docker push acovid/multi-server:latest
docker push acovid/multi-worker:latest

docker push acovid/multi-client:$SHA
docker push acovid/multi-server:$SHA
docker push acovid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=acovid/multi-server:$SHA
kubectl set image deployments/client-deployment client=acovid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=acovid/multi-worker:$SHA

