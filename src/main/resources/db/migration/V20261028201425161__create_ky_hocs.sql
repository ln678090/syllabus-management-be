CREATE TABLE ky_hocs (
    id UUID NOT NULL,

    code VARCHAR(20) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_ky_hocs
        PRIMARY KEY (id),

    CONSTRAINT uq_ky_hocs_code
        UNIQUE (code)
);
