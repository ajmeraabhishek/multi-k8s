docker build -t ajmeraabhishek/multi-client:latest -t ajmeraabhishek/multi-client:$SHA ./client/Dockerfile ./client
docker build -t ajmeraabhishek/multi-server:latest -t ajmeraabhishek/multi-server:$SHA ./server/Dockerfile ./server
docker build -t ajmeraabhishek/multi-worker:latest -t ajmeraabhishek/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push ajmeraabhishek/multi-client:latest
docker push ajmeraabhishek/multi-worker:latest
docker push ajmeraabhishek/multi-server:latest
docker push ajmeraabhishek/multi-client:$SHA
docker push ajmeraabhishek/multi-worker:$SHA
docker push ajmeraabhishek/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajmeraabhishek/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajmeraabhishek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajmeraabhishek/multi-worker:$SHA
