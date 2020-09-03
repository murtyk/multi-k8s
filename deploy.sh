docker build -t murtykorada/multi-client:latest -t murtykorada/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t murtykorada/multi-server:latest -t murtykorada/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t murtykorada/multi-worker:latest -t murtykorada/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push murtykorada/multi-client:latest
docker push murtykorada/multi-server:latest
docker push murtykorada/multi-worker:latest

docker push murtykorada/multi-client:$SHA
docker push murtykorada/multi-server:$SHA
docker push murtykorada/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=murtykorada/multi-server:$SHA
kubectl set image deployments/client-deployment client=murtykorada/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=murtykorada/multi-worker:$SHA
