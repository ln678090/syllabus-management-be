CREATE TABLE user_roles (
    id UUID NOT NULL,

    user_id UUID NOT NULL,
    role_id UUID NOT NULL,

    assigned_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_user_roles
        PRIMARY KEY (id),

    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_user_roles_user_role
        UNIQUE (user_id, role_id)
);
