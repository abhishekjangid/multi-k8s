docker build -t abhishekjangid/multi-client:latest -t abhishekjangid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhishekjangid/multi-server:latest -t abhishekjangid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhishekjangid/multi-worker:latest -t abhishekjangid/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push abhishekjangid/multi-client
docker push abhishekjangid/multi-server
docker push abhishekjangid/multi-worker

docker push abhishekjangid/multi-client:$SHA
docker push abhishekjangid/multi-server:$SHA
docker push abhishekjangid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abhishekjangid/multi-server:$SHA
kubectl set image deployments/client-deployment client=abhishekjangid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abhishekjangid/multi-worker:$SHA
