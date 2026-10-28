CREATE TABLE role_permissions (
    id UUID NOT NULL,

    role_id UUID NOT NULL,
    permission_id UUID NOT NULL,

    assigned_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_role_permissions
        PRIMARY KEY (id),

    CONSTRAINT fk_role_permissions_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_role_permissions_permission
        FOREIGN KEY (permission_id)
        REFERENCES permissions(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_role_permissions_role_permission
        UNIQUE (role_id, permission_id)
);
