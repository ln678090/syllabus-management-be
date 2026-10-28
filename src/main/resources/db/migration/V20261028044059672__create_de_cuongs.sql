CREATE TABLE de_cuongs (
    id UUID NOT NULL,

    mon_hoc_id UUID NOT NULL,


    created_by UUID,
    updated_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_de_cuongs
        PRIMARY KEY (id),

    CONSTRAINT fk_de_cuongs_mon_hoc
        FOREIGN KEY (mon_hoc_id)
        REFERENCES mon_hocs(id),

    CONSTRAINT fk_de_cuongs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_de_cuongs_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_de_cuongs_mon_hoc
    ON de_cuongs(mon_hoc_id);


