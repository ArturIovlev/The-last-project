class TableController < ApplicationController
  def input
    if (params[:nik]!=nil)
      @nik=params[:nik]
    end
    @admin=true
  end

  def view_one
    @nik =params[:nik]
    del =params[:del]
    input_name=params[:name]
    input_prof=params[:prof]
    input_time=params[:time]
    input_day=params[:day]
    input_cab=params[:cab]
    if del!=nil
      input_day=""
      unless CachedResult.find_by(id: del).nil?
        CachedResult.find_by(id: del).destroy
      end
      unless Record.find_by(unique: del).nil?
        Record.find_by(unique: del).destroy
      end
      del=nil
    end
    if input_name!=nil and input_prof!=nil and input_time!=nil and input_day!=nil and input_day!=""
      cached_result = CachedResult.new
      cached_result.name = input_name
      cached_result.profession = input_prof
      cached_result.day = input_day
      cached_result.time = input_time
      cached_result.cabinet = input_cab
      cached_result.save!
    end

    id_mon=[]
    @id_mon=[]
    CachedResult.all.each do |inst|
      if inst.day == "Mon"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_mon<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_mon<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_mon<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_mon=id_mon.sort_by{ |a| a.first.to_i }
    @id_mon=id_mon

    id_tue=[]
    @id_tue=[]
    CachedResult.all.each do |inst|
      if inst.day == "Tue"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_tue<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_tue<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_tue<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_tue=id_tue.sort_by{ |a| a.first.to_i }
    @id_tue=id_tue

    id_wed=[]
    @id_wed=[]
    CachedResult.all.each do |inst|
      if inst.day == "Wed"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_wed<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_wed<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_wed<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_wed=id_wed.sort_by{ |a| a.first.to_i }
    @id_wed=id_wed

    id_thu=[]
    @id_thu=[]
    CachedResult.all.each do |inst|
      if inst.day == "Thu"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_thu<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_thu<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_thu<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_thu=id_thu.sort_by{ |a| a.first.to_i }
    @id_thu=id_thu

    id_fri=[]
    @id_fri=[]
    CachedResult.all.each do |inst|
      if inst.day == "Fri"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_fri<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_fri<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_fri<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_fri=id_fri.sort_by{ |a| a.first.to_i }
    @id_fri=id_fri

    id_sat=[]
    @id_sat=[]
    CachedResult.all.each do |inst|
      if inst.day == "Sat"
        if input_day==nil
          if Record.find_by(unique: inst.id).nil?
            id_sat<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.id]
          else
            id_sat<<[inst.time,inst.name,inst.profession,inst.cabinet,-1]
          end
        else
          id_sat<<[inst.time,inst.name,inst.profession,inst.cabinet,-2,inst.id]
        end
      end
    end
    id_sat=id_sat.sort_by{ |a| a.first.to_i }
    @id_sat=id_sat
  end

  def cached
    res= CachedResult.all.map{|inst| {name: inst.name, profession: inst.profession, day: inst.day, time: inst.time, cabinet: inst.cabinet}}

    respond_to do |format|
      format.xml {render xml: res.to_xml}
      format.json {render json: res}
    end
  end

  def cached_two
    res= Record.all.map{|inst| {name: inst.name, unique: inst.unique}}

    respond_to do |format|
      format.xml {render xml: res.to_xml}
      format.json {render json: res}
    end
  end

  def view_two
    name=params[:nik]
    del=params[:del]
    if del!=nil
      Record.find_by(unique: del).destroy
      del=nil
    end
    @array=[]
    id=params[:res]
    @nik=name
    if id!=nil
      record = Record.find_or_initialize_by(unique: id)
      if record.new_record?
        record.name = name
        record.save!
        @resul="sve horosho zapisalos"
      end
    end
    Record.all.each do |i|
      if i.name==name
        CachedResult.all.each do |inst|
          if inst.id == i.unique
            @array<<[inst.time,inst.name,inst.profession,inst.cabinet,inst.day,inst.id]
          end
        end
      end
    end
  end

  def view_tree
    pass=params[:adm]
    unless pass == "1234"
      redirect_to table_input_path
    end
  end
end
