-- Program Learning Outcome - Chuan dau ra chuong trinh dao tao
CREATE TABLE plos (
    id UUID NOT NULL,

    chuong_trinh_id UUID NOT NULL,

    ma_plo VARCHAR(50) NOT NULL,
    mo_ta TEXT,

    sort_order INT NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_plos
        PRIMARY KEY (id),

    CONSTRAINT fk_plos_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id),

    CONSTRAINT fk_plos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_plos_chuong_trinh_ma_plo
        UNIQUE (chuong_trinh_id, ma_plo),

    CONSTRAINT uq_plos_chuong_trinh_sort_order
        UNIQUE (chuong_trinh_id, sort_order)
);

CREATE INDEX idx_plos_chuong_trinh
    ON plos(chuong_trinh_id);
