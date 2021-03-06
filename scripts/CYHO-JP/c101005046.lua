--サイバー・ドラゴン・ズィーガー
--Cyber Dragon Zieger
--Scripted by ahtelel
function c101005046.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(c101005046.matfilter),2,2,c101005046.lcheck)
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(70095154)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101005046,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1,101005046)
	e2:SetCondition(c101005046.con)
	e2:SetTarget(c101005046.target)
	e2:SetOperation(c101005046.operation)
	c:RegisterEffect(e2)	
end
function c101005046.matfilter(c,lc,sumtype,tp)
	return c:IsRace(RACE_MACHINE,lc,sumtype,tp)
end
function c101005046.lcheck(g,lc)
	return g:IsExists(Card.IsCode,1,nil,70095154)
end
function c101005046.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated() and e:GetHandler():GetAttackedCount()<1
end
function c101005046.filter(c)
	return c:IsFaceup() and c:IsAttackAbove(2100) and c:IsRace(RACE_MACHINE)
end
function c101005046.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c101005046.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101005046.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c101005046.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c101005046.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(2100)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
    		e3:SetType(EFFECT_TYPE_SINGLE)
    		e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
    		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    		c:RegisterEffect(e3)
    		local e4=Effect.CreateEffect(c)
    		e4:SetType(EFFECT_TYPE_SINGLE)
    		e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
    		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    		e4:SetValue(1)
    		c:RegisterEffect(e4)
	end
end
