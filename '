CREATE TABLE combos (
    id UUID NOT NULL,

    chuong_trinh_id UUID NOT NULL,

    code VARCHAR(100) NOT NULL,
    name VARCHAR(255),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_combos
        PRIMARY KEY (id),

    CONSTRAINT fk_combos_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_combos_chuong_trinh_code
        UNIQUE (chuong_trinh_id, code)
);

CREATE INDEX idx_combos_chuong_trinh
    ON combos(chuong_trinh_id);
