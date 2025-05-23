<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pelajaran extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'code', 'start_time', 'end_time'];

    public function absensisiswas()
    {
        return $this->hasMany(AbsensiSiswa::class);
    }
}
