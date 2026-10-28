-- Permission - Quyen thao tac trong he thong
CREATE TABLE permissions (
    id UUID NOT NULL,

    code VARCHAR(150) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_permissions
        PRIMARY KEY (id),

    CONSTRAINT uq_permissions_code
        UNIQUE (code)
);
