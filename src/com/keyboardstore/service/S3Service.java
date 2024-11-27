package com.keyboardstore.service;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.nio.file.Paths;

public class S3Service {

    private S3Client s3Client;
    public S3Service() {
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create("AKIAWN26JMORASNQOPFY", "Jw31V7QHCvxm5laGe8XirsXsThRx9bOTgE9wuy+7");

        this.s3Client = S3Client.builder()
                .region(Region.AP_SOUTHEAST_2) // Change to your region
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .build();
    }
    public String uploadFile(String bucketName, String keyName, String filePath) {
        try {
            PutObjectRequest putRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(keyName)
                    .build();

            s3Client.putObject(putRequest, RequestBody.fromFile(Paths.get(filePath)));
            return "https://" + bucketName + ".s3.amazonaws.com/" + keyName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
