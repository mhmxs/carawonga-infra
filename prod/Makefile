export PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAQEegZ89+oYcWf8le3SxyvSdiQUhkp5SfhUdltf78lxWlUVnHrsfLfRfAX2CnRKndnXjKj0ScaAGq2+duqKVTyVQrqtYvb9xC7kQMwMq2Z0SjPATN1EaKm6FQnLAZsw4Q6uKEuXVCEQ0s7bbz3z8f6YXG3sAno8cciuLDTiMjtu/O/71yfrRmG29vs5kvl/k1lX9OfquWlHIOhjREO3y0BNN9K6WjnCgAdEsJZdJ+PPTFq/2ciWqrVxi29ooGZ4lhmUDAzJnSD4btHjuh33FnuDGi7IfHbX9jOUsxRyDG+huwh3hSP/gV4Va1jdBqijswha9uWAwioA0HyLMgrmqD rkovacs@Richard-Kovacs-MBP.local"

render:
	@eval "echo \"$$(cat infra.yml)\""

transpile-fcct:
	docker run -i --rm quay.io/coreos/fcct:release --pretty --strict < infra.yml > infra.ign