sequenceDiagram
    autonumber
    participant Browser
    participant Gateway as API-Gateway
    participant UploadSvc as upload-svc
    participant MinIO
    participant ParseQ   as parse-queue (Redis)

    Browser->>Gateway: POST /api/v1/upload\nmultipart/form-data (PDF)
    Note right of Browser: JWT в заголовке Authorization
    Gateway->>UploadSvc: POST /upload (PDF + JWT claims)
    UploadSvc->>MinIO: putObject(file.pdf)
    UploadSvc-->>Gateway: 201 {file_id:"abc123"}
    Gateway-->>Browser: 201 {file_id:"abc123"}

    UploadSvc->>ParseQ: PUBLISH {file_id:"abc123", tenant_id:"42"}
    Note over ParseQ: дальше файл подберёт\nparse-svc / ocr-svc
