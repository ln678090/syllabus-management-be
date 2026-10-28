-- CLO-PLO Mapping - Anh xa chuan dau ra mon hoc voi chuan dau ra chuong trinh
CREATE TABLE clo_plos (
    id UUID NOT NULL,

    clo_id UUID NOT NULL,
    plo_id UUID NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_clo_plos
        PRIMARY KEY (id),

    CONSTRAINT fk_clo_plos_clo
        FOREIGN KEY (clo_id)
        REFERENCES clos(id),

    CONSTRAINT fk_clo_plos_plo
        FOREIGN KEY (plo_id)
        REFERENCES plos(id),

    CONSTRAINT fk_clo_plos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_clo_plos_clo_plo
        UNIQUE (clo_id, plo_id)
);

CREATE INDEX idx_clo_plos_clo_id
    ON clo_plos(clo_id);

CREATE INDEX idx_clo_plos_plo_id
    ON clo_plos(plo_id);
