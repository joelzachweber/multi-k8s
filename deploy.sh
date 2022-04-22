docker build -t joelweber/multi-client:latest -t joelweber/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joelweber/multi-server:latest -t joelweber/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joelweber/multi-worker:latest -t joelweber/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push joelweber/multi-client:latest
docker push joelweber/multi-server:latest
docker push joelweber/multi-worker:latest
docker push joelweber/multi-client:$SHA
docker push joelweber/multi-server:$SHA
docker push joelweber/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=joelweber/multi-server:$SHA
kubectl set image deployments/client-deployment client=joelweber/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=joelweber/multi-worker:$SHA