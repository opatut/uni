#!/bin/bash

FILES="familie medien medien2 galaxy systematik display stimmhaft stimmlos test textindex"

for FILE in $FILES; do
    wget "https://nats-www.informatik.uni-hamburg.de/pub/Prolog1415/VeranstaltungsMaterial/${FILE}.pl"
done
