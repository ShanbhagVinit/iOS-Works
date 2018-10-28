#! /bin/bash
# Script to copy db

SRC_DIR="$HOME/Desktop/gita.sqlite"
PROJECT_DIR="$(cd ../ && pwd)"
DEST_DIR="$SRCROOT/Bhagavadgeetha/Resource/"

echo "Project Bhagavadgeetha"
echo $SRC_DIR
echo $DEST_DIR
cp "$SRC_DIR" "$DEST_DIR"
