docker build -t sadhman/multi-client:latest -t sadhman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sadhman/multi-server:latest -t sadhman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sadhman/multi-worker:latest -t sadhman/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sadhman/multi-client:latest
docker push sadhman/multi-server:latest
docker push sadhman/multi-worker:latest
docker push sadhman/multi-client:$SHA
docker push sadhman/multi-server:$SHA
docker push sadhman/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sadhman/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sadhman/multi-worker:$SHA
kubectl set image deployments/client-deployment client=sadhman/multi-client:$SHA

