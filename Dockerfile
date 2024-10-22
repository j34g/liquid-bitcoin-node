# Use the official Blockstream elementsd image
FROM blockstream/elementsd:latest

# Set the working directory inside the container
WORKDIR /root/.elements

# Expose the Liquid network P2P port
EXPOSE 7041

# Define the default command to run the Liquid node in Liquid mode
CMD ["elementsd", "-chain=liquidv1"]
