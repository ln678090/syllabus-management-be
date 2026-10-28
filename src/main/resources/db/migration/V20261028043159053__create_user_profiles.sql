CREATE TABLE user_profiles (
    id UUID NOT NULL,
    user_id UUID NOT NULL,

    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    avatar_url VARCHAR(500),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_user_profiles
        PRIMARY KEY (id),

    CONSTRAINT uq_user_profiles_user
        UNIQUE (user_id),

    CONSTRAINT fk_user_profiles_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);
