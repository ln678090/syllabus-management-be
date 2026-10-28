-- Session - CLO Mapping
-- Lien ket buoi hoc voi chuan dau ra mon hoc trong cung mot phien ban de cuong
CREATE TABLE buoi_hoc_clos (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,
    buoi_hoc_id UUID NOT NULL,
    clo_id UUID NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_buoi_hoc_clos
        PRIMARY KEY (id),

    CONSTRAINT fk_buoi_hoc_clos_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_buoi_hoc_clos_buoi_hoc_phien_ban
        FOREIGN KEY (
            buoi_hoc_id,
            phien_ban_de_cuong_id
        )
        REFERENCES buoi_hocs (
            id,
            phien_ban_de_cuong_id
        ),

    CONSTRAINT fk_buoi_hoc_clos_clo_phien_ban
        FOREIGN KEY (
            clo_id,
            phien_ban_de_cuong_id
        )
        REFERENCES clos (
            id,
            phien_ban_de_cuong_id
        ),

    CONSTRAINT fk_buoi_hoc_clos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_buoi_hoc_clos
        UNIQUE (
            buoi_hoc_id,
            clo_id
        )
);

CREATE INDEX idx_buoi_hoc_clos_phien_ban
    ON buoi_hoc_clos(phien_ban_de_cuong_id);

CREATE INDEX idx_buoi_hoc_clos_buoi_hoc
    ON buoi_hoc_clos(buoi_hoc_id);

CREATE INDEX idx_buoi_hoc_clos_clo
    ON buoi_hoc_clos(clo_id);
