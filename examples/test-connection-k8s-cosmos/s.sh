kubectl apply -f python.yaml
# kubectl exec -it deploy/python-infra -- python /src/cosmosexample.py
kubectl exec -it deploy/python-infra -- python /src/infra.py