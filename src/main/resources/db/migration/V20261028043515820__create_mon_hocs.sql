CREATE TABLE mon_hocs (
    id UUID NOT NULL,

    ma_mon VARCHAR(50) NOT NULL,
    ten_mon VARCHAR(500) NOT NULL,
    ten_tieng_anh VARCHAR(500),

    external_id VARCHAR(100),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_by UUID,
    updated_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_mon_hocs
        PRIMARY KEY (id),

    CONSTRAINT uq_mon_hocs_ma_mon
        UNIQUE (ma_mon),

    CONSTRAINT fk_mon_hocs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_mon_hocs_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_mon_hocs_ten_mon
    ON mon_hocs (ten_mon);

CREATE INDEX idx_mon_hocs_is_active
    ON mon_hocs (is_active);
