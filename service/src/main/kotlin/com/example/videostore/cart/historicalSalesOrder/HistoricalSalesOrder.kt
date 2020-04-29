package com.example.videostore.cart.historicalSalesOrder

import com.example.videostore.user.User
import java.time.LocalDateTime
import java.util.*
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.OneToOne

@Entity
class HistoricalSalesOrder (
    @Id
    val id: UUID = UUID.randomUUID(),
    @OneToOne
    val user: User = User(),
    val createdOn: LocalDateTime = LocalDateTime.now(),
    val updatedOn: LocalDateTime = LocalDateTime.now(),
    val finalizedOn: LocalDateTime = LocalDateTime.now()
)