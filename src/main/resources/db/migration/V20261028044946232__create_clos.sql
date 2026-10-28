-- Course Learning Outcome - Chuan dau ra mon hoc
CREATE TABLE clos (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,

    ma_clo VARCHAR(50) NOT NULL,
    mo_ta TEXT NOT NULL,

    sort_order INT NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_clos
        PRIMARY KEY (id),

    CONSTRAINT fk_clos_phien_ban_de_cuong
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_clos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_clos_phien_ban_ma_clo
        UNIQUE (phien_ban_de_cuong_id, ma_clo),

    CONSTRAINT uq_clos_phien_ban_sort_order
        UNIQUE (phien_ban_de_cuong_id, sort_order),

    CONSTRAINT uq_clos_id_phien_ban
        UNIQUE (id, phien_ban_de_cuong_id)
);

CREATE INDEX idx_clos_phien_ban_de_cuong
    ON clos(phien_ban_de_cuong_id);
