def hash_partition(records, num_partitions, partition_key):
    """
    Perform hash partitioning on a list of records.

    Parameters:
        records (list): List of dictionaries representing records.
        num_partitions (int): Number of partitions (nodes) to create.
        partition_key (str): The attribute to use as the partitioning key.

    Returns:
        list: A list of lists containing the partitioned records.
    """
    partitions = [[] for _ in range(num_partitions)]

    for record in records:
        # Calculate the hash value for the partition key using Python's built-in hash function
        hash_value = hash(record[partition_key])

        # Map the hash value to a partition index using modulo operator
        partition_index = hash_value % num_partitions

        # Add the record to the appropriate partition
        partitions[partition_index].append(record)

    return partitions


# Example usage:
if __name__ == "__main__":
    # Sample list of records (dictionaries)
    records = [
        {"id": 1, "name": "Alice", "age": 30},
        {"id": 2, "name": "Bob", "age": 25},
        {"id": 3, "name": "Charlie", "age": 35},
        {"id": 4, "name": "David", "age": 28},
        {"id": 5, "name": "Eva", "age": 22},
        {"id": 6, "name": "Frank", "age": 40},
    ]

    num_partitions = 3  # Number of partitions (nodes) to create
    partition_key = "id"  # Attribute to use as the partitioning key

    # Perform hash partitioning
    partitions = hash_partition(records, num_partitions, partition_key)

    # Print the partitioned records
    for i, partition in enumerate(partitions):
        print(f"Partition {i}: {partition}")
